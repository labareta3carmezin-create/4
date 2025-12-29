Add-Type -AssemblyName PresentationFramework, System.Windows.Forms, System.Drawing

$xml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="LOST ENGINE | SUPREME TWEAKS (WIN 10/11)" Height="850" Width="1200" Background="#121317">
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
                <Button x:Name="BtnStandard" Content="Standard (Safe)" Width="140" Height="32" Background="#2d303d" Foreground="White" Margin="0,0,10,0" Cursor="Hand"/>
                <Button x:Name="BtnMinimal" Content="Minimal (Gaming)" Width="140" Height="32" Background="#2d303d" Foreground="White" Margin="0,0,10,0" Cursor="Hand"/>
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
                    <CheckBox x:Name="chkTele" Content="Disable Telemetry" IsChecked="True" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkDVR" Content="Disable GameDVR (FPS Boost)" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkPower" Content="Enable Lost e Vinizin Oprimizer Power Plan" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkDisk" Content="Optimize Disk &amp; TRIM" Foreground="White" Margin="0,5"/>
                    
                    <TextBlock Text="Advanced Tweaks" Foreground="OrangeRed" FontSize="18" FontWeight="Bold" Margin="0,30,0,15"/>
                    <CheckBox x:Name="chkEdge" Content="Remove Edge &amp; WebView" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkApps" Content="Disable Background Apps" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkIPv6" Content="Disable IPv6" Foreground="White" Margin="0,5"/>
                </StackPanel>

                <StackPanel Grid.Column="1" Margin="20">
                    <TextBlock Text="Customize Preferences" Foreground="RoyalBlue" FontSize="18" FontWeight="Bold" Margin="0,0,0,15"/>
                    <CheckBox x:Name="chkDark" Content="System Dark Theme" IsChecked="True" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkMouse" Content="Disable Mouse Acceleration" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkHidden" Content="Show Hidden Files" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkNet" Content="Gaming Network Tweak" Foreground="White" Margin="0,5"/>
                    
                    <TextBlock Text="Windows 11 Only" Foreground="Cyan" FontSize="18" FontWeight="Bold" Margin="0,30,0,15"/>
                    <CheckBox x:Name="chkWidgets" Content="Disable Widgets &amp; Chat" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkMenu" Content="Win 10 Classic Context Menu" Foreground="White" Margin="0,5"/>
                </StackPanel>
            </Grid>
        </ScrollViewer>

        <StackPanel Grid.Row="3" Orientation="Horizontal" Background="#1c1e26" VerticalAlignment="Center" Padding="30,0">
            <Button x:Name="RunBtn" Content="RUN TWEAKS" Width="220" Height="45" Background="RoyalBlue" Foreground="White" FontWeight="Bold" Margin="0,0,20,0" Cursor="Hand"/>
            <Button x:Name="UndoBtn" Content="UNDO TWEAKS" Width="220" Height="45" Background="#2d303d" Foreground="White" FontWeight="Bold" Cursor="Hand"/>
        </StackPanel>
    </Grid>
</Window>
"@

$reader = [XML.XmlReader]::Create([System.IO.StringReader]$xml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# --- BOTÕES DE SELEÇÃO ---
$window.FindName("BtnStandard").Add_Click({
    $window.FindName("chkRestore").IsChecked = $true
    $window.FindName("chkTemp").IsChecked = $true
    $window.FindName("chkPower").IsChecked = $true
})

# --- EXECUÇÃO ---
$RunBtn = $window.FindName("RunBtn")
$RunBtn.Add_Click({
    if ($window.FindName("chkPower").IsChecked) {
        Write-Host "Configurando Plano: Lost e Vinizin Oprimizer..." -ForegroundColor Yellow
        # Importa o Desempenho Máximo
        $guid = (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61).Split(' ')[-1]
        # Renomeia o plano
        powercfg -changename $guid "Lost e Vinizin Oprimizer"
        # Ativa o plano
        powercfg /setactive $guid
    }
    
    if ($window.FindName("chkTemp").IsChecked) { Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue }
    if ($window.FindName("chkNet").IsChecked) { netsh int tcp set global autotuninglevel=disabled; ipconfig /flushdns }

    [Windows.Forms.MessageBox]::Show("Otimizações concluídas! O plano de energia 'Lost e Vinizin Oprimizer' foi ativado.", "Lost Engine")
})

$window.ShowDialog()
