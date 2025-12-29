Add-Type -AssemblyName PresentationFramework, System.Windows.Forms, System.Drawing

$xml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="LOST ENGINE | SUPREME TWEAKS" Height="850" Width="1200" Background="#121317" WindowStartupLocation="CenterScreen">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="50"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="75"/>
        </Grid.RowDefinitions>

        <StackPanel Grid.Row="0" Orientation="Horizontal" Background="#1c1e26">
            <Button Content="Install" Width="110" Background="Transparent" Foreground="White" BorderThickness="0"/>
            <Button Content="Tweaks" Width="110" Background="#2d303d" Foreground="Cyan" BorderThickness="1" BorderBrush="Cyan"/>
            <Button Content="Config" Width="110" Background="Transparent" Foreground="White" BorderThickness="0"/>
            <Button Content="Updates" Width="110" Background="Transparent" Foreground="White" BorderThickness="0"/>
        </StackPanel>

        <StackPanel Grid.Row="1" Margin="25,15" Orientation="Vertical">
            <TextBlock Text="Seleções Recomendadas:" Foreground="DodgerBlue" FontWeight="Bold" Margin="0,0,0,10"/>
            <StackPanel Orientation="Horizontal">
                <Button x:Name="BtnStandard" Content="Standard (Seguro)" Width="140" Height="32" Background="#2d303d" Foreground="White" Margin="0,0,10,0"/>
                <Button x:Name="BtnMinimal" Content="Minimal (Gaming)" Width="140" Height="32" Background="#2d303d" Foreground="White" Margin="0,0,10,0"/>
                <Button x:Name="BtnClear" Content="Limpar Tudo" Width="140" Height="32" Background="#2d303d" Foreground="White"/>
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
                    <CheckBox x:Name="chkRestore" Content="Criar Ponto de Restauração" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkTemp" Content="Limpar Arquivos Temporários" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkTele" Content="Desativar Telemetria" IsChecked="True" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkPower" Content="Ativar Modo Lost e Vinizin Oprimizer" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkDisk" Content="Otimizar Disco (TRIM/SSD)" Foreground="White" Margin="0,5"/>
                </StackPanel>

                <StackPanel Grid.Column="1" Margin="20">
                    <TextBlock Text="Customize Preferences" Foreground="RoyalBlue" FontSize="18" FontWeight="Bold" Margin="0,0,0,15"/>
                    <CheckBox x:Name="chkDark" Content="Ativar Modo Escuro" IsChecked="True" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkMouse" Content="Desativar Aceleração do Mouse" Foreground="White" Margin="0,5"/>
                    <CheckBox x:Name="chkNet" Content="Otimização de Rede para Jogos" Foreground="White" Margin="0,5"/>
                    <TextBlock Text="Windows 11" Foreground="Cyan" FontSize="18" FontWeight="Bold" Margin="0,25,0,15"/>
                    <CheckBox x:Name="chkMenu" Content="Menu de Contexto Clássico" Foreground="White" Margin="0,5"/>
                </StackPanel>
            </Grid>
        </ScrollViewer>

        <Grid Grid.Row="3" Background="#1c1e26">
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Left" Margin="25,0,0,0">
                <Button x:Name="RunBtn" Content="EXECUTAR OTIMIZAÇÃO" Width="250" Height="45" Background="RoyalBlue" Foreground="White" FontWeight="Bold" Margin="0,0,20,0"/>
                <Button x:Name="UndoBtn" Content="DESFAZER" Width="250" Height="45" Background="#2d303d" Foreground="White" FontWeight="Bold"/>
            </StackPanel>
        </Grid>
    </Grid>
</Window>
"@

$reader = [XML.XmlReader]::Create([System.IO.StringReader]$xml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# --- FUNÇÕES DOS BOTÕES ---
$window.FindName("BtnStandard").Add_Click({
    $window.FindName("chkRestore").IsChecked = $true
    $window.FindName("chkTemp").IsChecked = $true
    $window.FindName("chkTele").IsChecked = $true
})

$window.FindName("BtnClear").Add_Click({
    $window.FindName("chkRestore").IsChecked = $false
    $window.FindName("chkTemp").IsChecked = $false
    $window.FindName("chkPower").IsChecked = $false
})

$RunBtn = $window.FindName("RunBtn")
$RunBtn.Add_Click({
    if ($window.FindName("chkPower").IsChecked) {
        $guid = (powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61).Split(' ')[-1]
        powercfg -changename $guid "Lost e Vinizin Oprimizer"
        powercfg /setactive $guid
    }
    [Windows.Forms.MessageBox]::Show("Otimização concluída!", "Lost Engine")
})

$window.ShowDialog()
