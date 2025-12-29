Add-Type -AssemblyName PresentationFramework, System.Windows.Forms, System.Drawing

$xml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="LOST ENGINE | TWEAKS" Height="850" Width="1200" Background="#121317">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="50"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="70"/>
        </Grid.RowDefinitions>

        <StackPanel Grid.Row="0" Orientation="Horizontal" Background="#1c1e26">
            <Button Content="Install" Width="110" Background="Transparent" Foreground="White" BorderThickness="0"/>
            <Button Content="Tweaks" Width="110" Background="#2d303d" Foreground="Cyan" BorderThickness="1" BorderBrush="Cyan"/>
            <Button Content="Config" Width="110" Background="Transparent" Foreground="White" BorderThickness="0"/>
            <Button Content="Updates" Width="110" Background="Transparent" Foreground="White" BorderThickness="0"/>
            <Button Content="MicroWin" Width="110" Background="Transparent" Foreground="White" BorderThickness="0"/>
        </StackPanel>

        <StackPanel Grid.Row="1" Margin="20,10">
            <TextBlock Text="Recommended Selections:" Foreground="DodgerBlue" FontWeight="Bold" Margin="0,0,0,10"/>
            <StackPanel Orientation="Horizontal">
                <Button x:Name="BtnStandard" Content="Standard" Width="140" Height="30" Background="#2d303d" Foreground="White" Margin="0,0,10,0"/>
                <Button x:Name="BtnMinimal" Content="Minimal" Width="140" Height="30" Background="#2d303d" Foreground="White" Margin="0,0,10,0"/>
                <Button x:Name="BtnClear" Content="Clear" Width="140" Height="30" Background="#2d303d" Foreground="White" Margin="0,0,10,0"/>
                <Button x:Name="BtnGetInstalled" Content="Get Installed" Width="140" Height="30" Background="#2d303d" Foreground="White"/>
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
                    <CheckBox x:Name="CreateRestorePoint" Content="Create Restore Point" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="DeleteTempFiles" Content="Delete Temporary Files" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="DisableTelemetry" Content="Disable Telemetry" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="DisableGameDVR" Content="Disable GameDVR" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="DisableHibernation" Content="Disable Hibernation" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="DisableStorageSense" Content="Disable Storage Sense" Foreground="White" Margin="0,4"/>
                    
                    <TextBlock Text="Advanced Tweaks - CAUTION" Foreground="OrangeRed" FontSize="18" FontWeight="Bold" Margin="0,25,0,12"/>
                    <CheckBox x:Name="EdgeDebloat" Content="Edge Debloat" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="DisableBackgroundApps" Content="Disable Background Apps" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="DisableIPv6" Content="Disable IPv6" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="DisableRecall" Content="Disable Recall" Foreground="White" Margin="0,4"/>
                </StackPanel>

                <StackPanel Grid.Column="1" Margin="15">
                    <TextBlock Text="Customize Preferences" Foreground="RoyalBlue" FontSize="18" FontWeight="Bold" Margin="0,0,0,12"/>
                    <CheckBox x:Name="DarkTheme" Content="Dark Theme for Windows" IsChecked="True" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="BingSearch" Content="Bing Search in Start Menu" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="MouseAcceleration" Content="Disable Mouse Acceleration" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="ShowHiddenFiles" Content="Show Hidden Files" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="ShowFileExtensions" Content="Show File Extensions" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="CenterTaskbar" Content="Center Taskbar Items" Foreground="White" Margin="0,4"/>
                    <CheckBox x:Name="WidgetsButton" Content="Widgets Button in Taskbar" Foreground="White" Margin="0,4"/>
                </StackPanel>
            </Grid>
        </ScrollViewer>

        <StackPanel Grid.Row="3" Orientation="Horizontal" Background="#1c1e26" VerticalAlignment="Center" Padding="25,0">
            <Button x:Name="RunBtn" Content="Run Tweaks" Width="200" Height="40" Background="RoyalBlue" Foreground="White" FontWeight="Bold" Margin="0,0,15,0"/>
            <Button x:Name="UndoBtn" Content="Undo Selected Tweaks" Width="200" Height="40" Background="#2d303d" Foreground="White" FontWeight="Bold"/>
        </StackPanel>
    </Grid>
</Window>
"@

# Corrigindo o carregamento do XML para evitar erros de prefixo
$reader = [XML.XmlReader]::Create([System.IO.StringReader]$xml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# --- Mapeamento de Funções do Botão RUN ---
$RunBtn = $window.FindName("RunBtn")
$RunBtn.Add_Click({
    Write-Host "Iniciando otimizações..." -ForegroundColor Cyan
    
    # Exemplo de lógica para as CheckBoxes
    if ($window.FindName("DeleteTempFiles").IsChecked) {
        Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "Arquivos temporários removidos." -ForegroundColor Yellow
    }
    
    [Windows.Forms.MessageBox]::Show("Tweaks concluídos!", "Lost Engine")
})

$window.ShowDialog()
