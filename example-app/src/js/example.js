import { AppCoinsSdk } from 'aptoide-appcoinssdk';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    AppCoinsSdk.echo({ value: inputValue })
}
