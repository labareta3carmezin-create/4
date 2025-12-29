Add-Type -AssemblyName PresentationFramework, System.Windows.Forms, System.Drawing

$xml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="LOST ENGINE | TWEAKS" Height="780" Width="1100" Background="#121317">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="50"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="65"/>
        </Grid.RowDefinitions>

        <StackPanel Grid.Row="0" Orientation="Horizontal" Background="#1c1e26">
            <Button Content="Install" Width="110" Background="Transparent" Foreground="White" BorderThickness="0"/>
            <Button Content="Tweaks" Width="110" Background="#2d303d" Foreground="Cyan" BorderThickness="1" BorderBrush="Cyan"/>
            <Button Content="Config" Width="110" Background="Transparent" Foreground="White" BorderThickness="0"/>
            <Button Content="Updates" Width="110" Background="Transparent" Foreground="White" BorderThickness="0"/>
            <Button Content="MicroWin" Width="110" Background="Transparent" Foreground="White" BorderThickness="0"/>
        </StackPanel>

        <StackPanel Grid.Row="1" Margin="20,10">
            <TextBlock Text="Recommended Selections:" Foreground="DodgerBlue" FontWeight="Bold" Margin="0,0,0,8"/>
            <StackPanel Orientation="Horizontal">
                <Button Content="Standard" Width="140" Height="28" Background="#2d303d" Foreground="White" Margin="0,0,8,0"/>
                <Button Content="Minimal" Width="140" Height="28" Background="#2d303d" Foreground="White" Margin="0,0,8,0"/>
                <Button Content="Clear" Width="140" Height="28" Background="#2d303d" Foreground="White" Margin="0,0,8,0"/>
                <Button Content="Get Installed" Width="140" Height="28" Background="#2d303d" Foreground="White"/>
            </StackPanel>
        </StackPanel>

        <ScrollViewer Grid.Row="2" Margin="10" VerticalScrollBarVisibility="Auto">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="*"/>
                </Grid.ColumnDefinitions>

                <StackPanel Grid.Column="0" Margin="15">
                    <TextBlock Text="Essential Tweaks" Foreground="RoyalBlue" FontSize="18" FontWeight="Bold" Margin="0,0,0,12"/>
                    <CheckBox x:Name="RestorePoint" Content="Create Restore Point" Foreground="LightGray" Margin="0,3"/>
                    <CheckBox x:Name="TempFiles" Content="Delete Temporary Files" Foreground="LightGray" Margin="0,3"/>
                    <CheckBox x:Name="Telemetry" Content="Disable Telemetry" Foreground="LightGray" Margin="0,3"/>
                    <CheckBox x:Name="GameDVR" Content="Disable GameDVR" Foreground="LightGray" Margin="0,3"/>
                    <CheckBox x:Name="Hibernation" Content="Disable Hibernation" Foreground="LightGray" Margin="0,3"/>
                    <CheckBox x:Name="Location" Content="Disable Location Tracking" Foreground="LightGray" Margin="0,3"/>
                    <CheckBox x:Name="StorageSense" Content="Disable Storage Sense" Foreground="LightGray" Margin="0,3"/>
                    
                    <TextBlock Text="Advanced Tweaks - CAUTION" Foreground="OrangeRed" FontSize="18" FontWeight="Bold" Margin="0,25,0,12"/>
                    <CheckBox x:Name="EdgeDebloat" Content="Edge Debloat" Foreground="LightGray" Margin="0,3"/>
                    <CheckBox x:Name="BackgroundApps" Content="Disable Background Apps" Foreground="LightGray" Margin="0,3"/>
                    <CheckBox x:Name="IPv6" Content="Disable IPv6" Foreground="LightGray" Margin="0,3"/>
                    <CheckBox x:Name="Recall" Content="Disable Recall" Foreground="LightGray" Margin="0,3"/>
                </StackPanel>

                <StackPanel Grid.Column="1" Margin="15">
                    <TextBlock Text="Customize Preferences" Foreground="RoyalBlue" FontSize="18" FontWeight="Bold" Margin="0,0,0,12"/>
                    <CheckBox x:Name="DarkTheme" Content="Dark Theme for Windows" IsChecked="True" Foreground="LightGray" Margin="0,3"/>
                    <CheckBox x:Name="BingSearch" Content="Bing Search in Start Menu" Foreground="LightGray" Margin="0,3"/>
                    <CheckBox x:Name="MouseAccel" Content="Disable Mouse Acceleration" Foreground="LightGray" Margin="0,3"/>
                    <CheckBox x:Name="HiddenFiles" Content="Show Hidden Files" Foreground="LightGray" Margin="0,3"/>
                    <CheckBox x:Name="FileExt" Content="Show File Extensions" Foreground="LightGray" Margin="0,3"/>
                    <CheckBox x:Name="TaskbarCenter" Content="Center Taskbar Items" Foreground="LightGray" Margin="0,3"/>
                    <CheckBox x:Name="Widgets" Content="Widgets Button in Taskbar" Foreground="LightGray" Margin="0,3"/>
                </StackPanel>
            </Grid>
        </ScrollViewer>

        <StackPanel Grid.Row="3" Orientation="Horizontal" Background="#1c1e26" VerticalAlignment="Center" Padding="25,0">
            <Button x:Name="RunBtn" Content="Run Tweaks" Width="200" Height="35" Background="#2d303d" Foreground="White" FontWeight="Bold" Margin="0,0,15,0"/>
            <Button x:Name="UndoBtn" Content="Undo Selected Tweaks" Width="200" Height="35" Background="#2d303d" Foreground="White" FontWeight="Bold"/>
        </StackPanel>
    </Grid>
</Window>
"@

# Corrigindo o leitor para aceitar o XML
$reader = [XML.XmlReader]::Create([System.IO.StringReader]$xml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# --- Mapeamento de Funções ---
$RunBtn = $window.FindName("RunBtn")
$RunBtn.Add_Click({
    Write-Host "Executando otimizações..." -ForegroundColor Cyan
    # Adicione aqui os comandos de cada CheckBox se desejar que funcionem ao clicar
    [Windows.Forms.MessageBox]::Show("Processo finalizado!", "Lost Engine")
})

$window.ShowDialog()
