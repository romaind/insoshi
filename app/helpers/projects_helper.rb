module ProjectsHelper
  
  def cc_icons(common)
    case common.label
    when 'All rights reserved'
      "<p class='bot0 top10'>All rights reserved</p>"
    when 'Attribution'
      "<p class='bot0 top10'><a rel='license' href='http://creativecommons.org/licenses/by/3.0/' target='_blank'><img alt='Creative Commons License' style='border-width:0' src='http://i.creativecommons.org/l/by/3.0/88x31.png' /></a></p><p class='small bot0'>Cette création est mise à disposition sous un <a rel='license' href='http://creativecommons.org/licenses/by/3.0/' target='_blank'>contrat Creative Commons</a>.</p>"
      
    when 'Attribution-Noncommercial'
      "<p class='bot0 top10'><a rel='license' href='http://creativecommons.org/licenses/by-nc/3.0/' target='_blank'><img alt='Creative Commons License' style='border-width:0' src='http://i.creativecommons.org/l/by-nc/3.0/88x31.png' /></a></p><p class='small bot0'>Cette création est mise à disposition sous un <a rel='license' href='http://creativecommons.org/licenses/by-nc/3.0/' target='_blank'>contrat Creative Commons</a>.</p>"
      
    when 'Attribution-Noncommercial-No Derivative Works'
      "<p class='bot0 top10'><a rel='license' href='http://creativecommons.org/licenses/by-nc-nd/3.0/' target='_blank'><img alt='Creative Commons License' style='border-width:0' src='http://i.creativecommons.org/l/by-nc-nd/3.0/88x31.png' /></a></p><p class='small bot0'>Cette création est mise à disposition sous un <a rel='license' href='http://creativecommons.org/licenses/by-nc-nd/3.0/' target='_blank'>contrat Creative Commons</a>.</p>"
      
    when 'Attribution-Noncommercial-Share Alike'
      "<p class='bot0 top10'><a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/3.0/' target='_blank'><img alt='Creative Commons License' style='border-width:0' src='http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png' /></a></p><p class='small bot0'>Cette création est mise à disposition sous un <a rel='license' href='http://creativecommons.org/licenses/by-nc-sa/3.0/' target='_blank'>contrat Creative Commons</a>.</p>"
      
    when 'Attribution-No Derivative Works'
      "<p class='bot0 top10'><a rel='license' href='http://creativecommons.org/licenses/by-nd/3.0/' target='_blank'><img alt='Creative Commons License' style='border-width:0' src='http://i.creativecommons.org/l/by-nd/3.0/88x31.png' /></a></p><p class='small bot0'>Cette création est mise à disposition sous un <a rel='license' href='http://creativecommons.org/licenses/by-nd/3.0/' target='_blank'>contrat Creative Commons</a>.</p>"
      
    when 'Attribution-Share Alike'
      "<p class='bot0 top10'><a rel='license' href='http://creativecommons.org/licenses/by-sa/3.0/' target='_blank'><img alt='Creative Commons License' style='border-width:0' src='http://i.creativecommons.org/l/by-sa/3.0/88x31.png' /></a></p><p class='small bot0'>Cette création est mise à disposition sous un <a rel='license' href='http://creativecommons.org/licenses/by-sa/3.0/' target='_blank'>contrat Creative Commons</a>.</p>"
    end
  end
  
end
