//   decimal_to_fixed_point.sce

//   Converts a decimal number to an 8.8 fixed point value

//   copyright James Holland 2018

//   This code is free software; you can redistribute it and/or 
//   modify it under the terms of the GNU Lesser General Public 
//   License as published by the Free Software Foundation; either 
//   version 2.1 of the License, or (at your option) any later version. 
//  
//   This code is distributed in the hope that it will be useful, 
//   but WITHOUT ANY WARRANTY; without even the implied warranty of 
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU 
//   Lesser General Public License for more details. 
  
//   You should have received a copy of the GNU Lesser General 
//   Public License along with this code; if not, write to the 
//   Free Software Foundation, Inc., 59 Temple Place, Suite 330, 
//   Boston, MA  02111-1307  USA 
    
//   James Holland 
//   Version 1 - 25th January 2018 



dec_value = [14.7];

mod_value = uint8(dec_value);
rem_value = modulo(dec_value,1);

hex_value = dec2hex(mod_value);


bit_weight = 128;
bit_value = 0.5;
out_value = 0;
tmp_value = 0;
calc_value = 0;

for n = 1 : 8 
    tmp_value = rem_value-bit_value;
    if tmp_value>=0
        rem_value=tmp_value;
        out_value = out_value + bit_weight;
        calc_value = calc_value + bit_value;
    end
    bit_weight=bit_weight/2;
    bit_value = bit_value/2;
end

dec_str = string(dec_value);
dec_str = 'Decimal Input=' + dec_str;

calc_value=calc_value + double(mod_value);
calc_str = string(calc_value);
calc_str = 'decimal=' + calc_str; 

out_value_L = uint8(out_value);
hex_value_L = dec2hex(out_value_L);
hex_value = hex_value + hex_value_L; 
hex_str = 'Hex value=' + '0x' + hex_value;

error_value = dec_value- calc_value;
error_value = (error_value/dec_value)*100;
err_str = string(error_value);
err_str = 'error=' + err_str + '%';

disp(dec_str);
disp(hex_str);
disp(calc_str);
disp(err_str);




       
 








