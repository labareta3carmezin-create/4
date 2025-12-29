Add-Type -AssemblyName PresentationFramework, System.Windows.Forms, System.Drawing

$xml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="LOST ENGINE | ULTIMATE TWEAKS" Height="850" Width="1200" Background="#121317">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="50"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="75"/>
        </Grid.RowDefinitions>

        <StackPanel Grid.Row="0" Orientation="Horizontal" Background="#1c1e26">
            <Button Content="Install" Width="110" Background="Transparent" Foreground="White" BorderThickness="0" Cursor="Hand"/>
            <Button Content="Tweaks" Width="110" Background="#2d303d" Foreground="Cyan" BorderThickness="1" BorderBrush="Cyan"/>
            <Button Content="Config" Width="110" Background="Transparent" Foreground="White" BorderThickness="0"/>
            <Button Content="Updates" Width="110" Background="Transparent" Foreground="White" BorderThickness="0"/>
            <Button Content="MicroWin" Width="110" Background="Transparent" Foreground="White" BorderThickness="0"/>
        </StackPanel>

        <StackPanel Grid.Row="1" Margin="25,15">
            <TextBlock Text="Recommended Selections:" Foreground="DodgerBlue" FontWeight="Bold" Margin="0,0,0,10"/>
            <StackPanel Orientation="Horizontal">
                <Button x:Name="BtnStandard" Content="Standard" Width="140" Height="32" Background="#2d303d" Foreground="White" Margin="0,0,10,0" Cursor="Hand"/>
                <Button x:Name="BtnMinimal" Content="Minimal" Width="140" Height="32" Background="#2d303d" Foreground="White" Margin="0,0,10,0" Cursor="Hand"/>
                <Button x:Name="BtnClear" Content="Clear All" Width="140" Height="32" Background="#2d303d" Foreground="White" Cursor="Hand"/>
            </StackPanel>
        </StackPanel>

        <ScrollViewer Grid.Row="2" Margin="10" VerticalScrollBarVisibility="Auto">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <StackPanel Grid.Column="0" Margin="20">
                    <TextBlock Text="Essential Tweaks" Foreground="RoyalBlue" FontSize="18" FontWeight="Bold" Margin="0,0,0,15"/>
                    <CheckBox x:Name="chkRestore" Content="Create Restore Point" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkTemp" Content="Delete Temporary Files" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkTele" Content="Disable Telemetry &amp; Data Collection" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkDVR" Content="Disable GameDVR (FPS Boost)" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkHiber" Content="Disable Hibernation" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="chkDisk" Content="Optimize Disk (TRIM/Defrag)" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkRAM" Content="Clear RAM Standby List" Foreground="White" Margin="0,5"/>
                    
                    <TextBlock Text="Advanced Tweaks - CAUTION" Foreground="OrangeRed" FontSize="18" FontWeight="Bold" Margin="0,30,0,15"/>
                    <CheckBox x:Name="chkEdge" Content="Remove Microsoft Edge" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkApps" Content="Disable Background Apps" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkIPv6" Content="Disable IPv6" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkRecall" Content="Disable AI Recall (Win11)" Foreground="White" Margin="0,5"/>
                </StackPanel>

                <StackPanel Grid.Column="1" Margin="20">
                    <TextBlock Text="Customize Preferences" Foreground="RoyalBlue" FontSize="18" FontWeight="Bold" Margin="0,0,0,15"/>
                    <CheckBox x:Name="chkDark" Content="Enable System Dark Theme" IsChecked="True" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkMouse" Content="Disable Mouse Acceleration" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkHidden" Content="Show Hidden Files &amp; Folders" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkExt" Content="Show File Extensions" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkTask" Content="Center Taskbar Items (W10/W11)" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkNet" Content="Optimize Network for Gaming" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkPower" Content="Enable Ultimate Performance Plan" Foreground="White" Margin="0,5"/>
                </StackPanel>
            </Grid>
        </ScrollViewer>

        <StackPanel Grid.Row="3" Orientation="Horizontal" Background="#1c1e26" VerticalAlignment="Center" Padding="30,0">
            <Button x:Name="RunBtn" Content="RUN TWEAKS" Width="220" Height="42" Background="RoyalBlue" Foreground="White" FontWeight="Bold" Margin="0,0,20,0" Cursor="Hand"/>
            <Button x:Name="UndoBtn" Content="UNDO SELECTED" Width="220" Height="42" Background="#2d303d" Foreground="White" FontWeight="Bold" Cursor="Hand"/>
        </StackPanel>
    </Grid>
</Window>
"@

# Carregamento da Janela
$reader = [XML.XmlReader]::Create([System.IO.StringReader]$xml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# --- MAPEAMENTO DE BOTÕES DE SELEÇÃO RÁPIDA ---
$window.FindName("BtnStandard").Add_Click({
    $window.FindName("chkRestore").IsChecked = $true
    $window.FindName("chkTemp").IsChecked = $true
    $window.FindName("chkTele").IsChecked = $true
    $window.FindName("chkDVR").IsChecked = $true
    $window.FindName("chkRAM").IsChecked = $true
    $window.FindName("chkDark").IsChecked = $true
})

$window.FindName("BtnClear").Add_Click({
    $window.FindName("chkRestore").IsChecked = $false
    $window.FindName("chkTemp").IsChecked = $false
    $window.FindName("chkTele").IsChecked = $false
    $window.FindName("chkDVR").IsChecked = $false
    $window.FindName("chkRAM").IsChecked = $false
    $window.FindName("chkDark").IsChecked = $false
    $window.FindName("chkDisk").IsChecked = $false
})

# --- LÓGICA DE EXECUÇÃO ---
$RunBtn = $window.FindName("RunBtn")
$RunBtn.Add_Click({
    Write-Host ">>> LOST ENGINE: Aplicando Otimizações..." -ForegroundColor Cyan

    if ($window.FindName("chkRestore").IsChecked) { 
        Write-Host "Criando Ponto de Restauração..."
        Checkpoint-Computer -Description "LostEngineRestore" -RestorePointType "MODIFY_SETTINGS" -ErrorAction SilentlyContinue
    }
    
    if ($window.FindName("chkTemp").IsChecked) { 
        Write-Host "Limpando arquivos temporários..."
        Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    }

    if ($window.FindName("chkPower").IsChecked) {
        Write-Host "Ativando Plano Ultimate Performance..."
        powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
        powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
    }

    if ($window.FindName("chkNet").IsChecked) {
        Write-Host "Otimizando Rede..."
        netsh int tcp set global autotuninglevel=disabled
        ipconfig /flushdns | Out-Null
    }

    [Windows.Forms.MessageBox]::Show("Todas as tarefas foram concluídas com sucesso!", "Lost Engine")
})

$window.ShowDialog()
