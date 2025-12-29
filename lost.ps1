Add-Type -AssemblyName PresentationFramework, System.Windows.Forms

$xml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="LOST ENGINE | ULTIMATE TWEAKS" Height="750" Width="1050" Background="#1a1b1e">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <StackPanel Grid.Row="0" Orientation="Horizontal" Background="#2c2e33" Height="45">
            <Button Content="Install" Width="120" Background="Transparent" Foreground="White" BorderThickness="0" FontWeight="Bold"/>
            <Button Content="Tweaks" Width="120" Background="#3d4046" Foreground="Cyan" BorderThickness="0" FontWeight="Bold"/>
            <Button Content="Config" Width="120" Background="Transparent" Foreground="White" BorderThickness="0" FontWeight="Bold"/>
            <Button Content="MicroWin" Width="120" Background="Transparent" Foreground="White" BorderThickness="0" FontWeight="Bold"/>
        </StackPanel>

        <ScrollViewer Grid.Row="1" Margin="15">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <StackPanel Grid.Column="0" Margin="10">
                    <TextBlock Text="Essential Tweaks" Foreground="#3498db" FontSize="18" FontWeight="Bold" Margin="0,0,0,15"/>
                    <CheckBox x:Name="RestorePoint" Content="Create Restore Point" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="TempFiles" Content="Delete Temporary Files" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="Telemetry" Content="Disable Telemetry" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="GameDVR" Content="Disable GameDVR" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="Hibernation" Content="Disable Hibernation" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="DNS" Content="Set Google DNS" Foreground="White" Margin="0,4"/>
                    
                    <TextBlock Text="Advanced Tweaks - CAUTION" Foreground="#e74c3c" FontSize="18" FontWeight="Bold" Margin="0,25,0,15"/>
                    <CheckBox x:Name="EdgeDebloat" Content="Edge Debloat" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="BackgroundApps" Content="Disable Background Apps" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="IPv6" Content="Disable IPv6" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="ActionCenter" Content="Disable Action Center" Foreground="White" Margin="0,4"/>
                </StackPanel>

                <StackPanel Grid.Column="1" Margin="10">
                    <TextBlock Text="Customize Preferences" Foreground="#3498db" FontSize="18" FontWeight="Bold" Margin="0,0,0,15"/>
                    <CheckBox x:Name="DarkTheme" Content="Dark Theme for Windows" IsChecked="True" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="MouseAccel" Content="Disable Mouse Acceleration" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="HiddenFiles" Content="Show Hidden Files" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="FileExt" Content="Show File Extensions" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="TaskbarCenter" Content="Center Taskbar Items (Win10)" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="SnapAssist" Content="Disable Snap Assist" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="Widgets" Content="Disable Widgets (Win11)" Foreground="White" Margin="0,4"/>
                </StackPanel>
            </Grid>
        </ScrollViewer>

        <StackPanel Grid.Row="2" Orientation="Horizontal" Background="#232429" Height="60" Padding="20,0">
            <Button x:Name="RunBtn" Content="RUN TWEAKS" Width="180" Height="35" Background="RoyalBlue" Foreground="White" FontWeight="Bold" Margin="0,0,15,0"/>
            <Button x:Name="UndoBtn" Content="UNDO SELECTED" Width="180" Height="35" Background="#3d4046" Foreground="White" FontWeight="Bold"/>
        </StackPanel>
    </Grid>
</Window>
"@

$reader = [XML.XmlReader]::Create([System.IO.StringReader]$xml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# --- MAPEAMENTO DE FUNÇÕES ---
$RunBtn = $window.FindName("RunBtn")
$RunBtn.Add_Click({
    Write-Host "Iniciando Otimizações..." -ForegroundColor Cyan

    if ($window.FindName("RestorePoint").IsChecked) {
        Checkpoint-Computer -Description "LostEngineRestore" -RestorePointType "MODIFY_SETTINGS"
    }
    if ($window.FindName("TempFiles").IsChecked) {
        Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    }
    if ($window.FindName("Telemetry").IsChecked) {
        sc stop "DiagTrack"; sc config "DiagTrack" start= disabled
    }
    if ($window.FindName("GameDVR").IsChecked) {
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f
    }
    if ($window.FindName("MouseAccel").IsChecked) {
        reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /d "0" /f
    }
    if ($window.FindName("HiddenFiles").IsChecked) {
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f
    }

    [Windows.Forms.MessageBox]::Show("Todas as tarefas selecionadas foram concluídas!", "Lost Engine")
})

$window.ShowDialog()
