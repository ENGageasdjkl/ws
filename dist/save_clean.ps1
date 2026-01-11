# save_clean.ps1
Write-Host "⚠️  警告：这将删除所有Git历史！" -ForegroundColor Red
$confirm = Read-Host "继续吗？(y/n)"

if ($confirm -eq 'y') {
    # 备份远程URL（如果有）
    $remoteUrl = ""
    try {
        $remoteUrl = git remote get-url origin
        Write-Host "检测到远程仓库: $remoteUrl"
    } catch {
        Write-Host "没有远程仓库或获取失败"
    }
    
    # 备份.gitignore（如果有）
    if (Test-Path .gitignore) {
        Copy-Item .gitignore .gitignore.backup
    }
    
    # 删除.git目录
    if (Test-Path .git) {
        Remove-Item -Recurse -Force .git
        Write-Host "已删除 .git 文件夹"
    }
    
    # 重新初始化
    git init
    
    # 恢复.gitignore
    if (Test-Path .gitignore.backup) {
        Move-Item .gitignore.backup .gitignore -Force
    }
    
    # 添加远程仓库（如果之前有）
    if ($remoteUrl) {
        git remote add origin $remoteUrl
        Write-Host "已添加远程仓库: $remoteUrl"
    }
    
    # 初始提交
    git add .
    git commit -m "Initial commit"
    
    Write-Host "✅ 重新初始化完成！" -ForegroundColor Green
} else {
    Write-Host "❌ 操作取消" -ForegroundColor Yellow
}