<?php

namespace app\admin\controller;

use app\admin\library\module\Server;
use app\common\controller\Backend;
use app\admin\model\Account;

use FilesystemIterator;
use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;


class Dashboard extends Backend
{
    public function initialize(): void
    {
        parent::initialize();
    }

    public function index(): void
    {
        $account_count = Account::count();
        $account_today = Account::whereMonth('create_time')->count();
        $disk = config('filesystem.disks.public');
        $path = $disk['root'];
        $file_count = 0;
        $yearly_file_count = [];

        if (is_dir($path)) {
            $iterator = new RecursiveIteratorIterator(
                new RecursiveDirectoryIterator($path, FilesystemIterator::SKIP_DOTS)
            );
            foreach ($iterator as $file) {
                if ($file->isFile()) {
                    $file_count++;
                    // 获取文件所在目录名
                    $dirname = basename($file->getPath());
                    // 如果目录名符合 YYYYMMDD 格式
                    if (preg_match('/^\d{8}$/', $dirname)) {
                        $year = substr($dirname, 0, 4);
                        if (!isset($yearly_file_count[$year])) {
                            $yearly_file_count[$year] = 0;
                        }
                        $yearly_file_count[$year]++;
                    }
                }
            }
        }

        $week_start = date('Y-m-d', strtotime('monday this week'));

        $user_trend = [];
        for ($i = 0; $i < 7; $i++) {
            $date = date('Y-m-d', strtotime("$week_start +$i day"));
            $count = Account::whereDay('create_time', $date)->count();
            $user_trend[] = $count;
        }
        $latest_accounts = Account::order('create_time', 'desc')
            ->limit(3)
            ->field([ 'id','nickname', 'avatar'])
            ->select()
            ->toArray();
        $this->success('', [
            'remark' => get_route_remark(),
            'account_count' => $account_count,
            'latest_accounts' => $latest_accounts,
            'account_today' => $account_today,
            'file_count' => $file_count,
            'yearly_file_count' => $yearly_file_count,
            'installed_count' => count(Server::installedList(root_path() . 'modules' . DIRECTORY_SEPARATOR)),
            'user_trend' => $user_trend,
        ]);
    }

}