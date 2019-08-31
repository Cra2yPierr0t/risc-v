P1err0t-V
===
無計画に作ったRISC-Vコア. RV32IのFENCE, ECALL, EBREAK以外全ての命令が動作す
る. 高速化は何もしていないため, 安心と信頼の単一サイクルとなっております.

## Description
![DSC_1045](https://user-images.githubusercontent.com/48832611/64066182-bbff5180-cc51-11e9-9a82-ab5bb963a5f2.JPG)
この画像の様にモジュールを組み合わせて作ったので分かりやすい実装になる
はずだった, 実際は...

## Usage
1./Mem/ROM.vのmem[]にRISC-Vバイナリを直書きする
```
    initial begin
        for(i = 0; i < 64; i = i + 1)
            mem[i] = 32'h00000000;

        mem[3] = 32'b00000010101010101010000010110111;
        mem[4] = 32'b00000000000000000000000100010111;
    end
```
2.Icarus Verilogを使っている場合以下のコマンドでコンパイル, 実行が可能

コンパイル
```
$iverilog -o RISC-V_SIM -s Simulation Simulation.v Computer.v CPU.v DMux32.v Load_Length_Changer.v SignExtender.v SignExtender_jal.v SignExtender_bnc.v Store_Length_Changer.v branchcontroller.v controller.v ALU/ALU.v Mem/RAM.v Mem/ROM.v Reg/PC.v Reg/Regfile.v Reg/Register.v
```
実行
```
$ vvp RISC-V_SIM
```

波形を見たい場合は実行時生成されるwave.vcdをgtkwaveで見れる
```
$ gtkwave wave.vcd
```

## TODO
モダンな方法で再実装
