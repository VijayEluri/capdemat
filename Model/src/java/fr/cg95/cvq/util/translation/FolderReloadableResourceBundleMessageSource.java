package fr.cg95.cvq.util.translation;

import java.io.File;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

/**
 * @author jsb@zenexity.fr
 *
 */
public class FolderReloadableResourceBundleMessageSource extends
        ReloadableResourceBundleMessageSource {

    public void setPaths(String[] paths) throws IOException {
        Set<String> basenames = new HashSet<String>();
        for (String path : paths) {
            Resource resource = new ClassPathResource(path);
            if (resource.exists()) {
                basenames.addAll(parseBasenames(new File[]{resource.getFile()}, StringUtils.substringBeforeLast(path, "/")));
            }
        }
        setBasenames(basenames.toArray(new String[basenames.size()]));
    }

    private Set<String> parseBasenames(File[] files, String root) {
        Set<String> basenames = new HashSet<String>();
        for (File file : files) {
            if (file.isFile()) {
                basenames.add("classpath:" + root + "/" + parseBasename(file));
            } else if (file.isDirectory()) {
                basenames.addAll(parseBasenames(file.listFiles(), root + "/" + file.getName()));
            }
        }
        return basenames;
    }

    private String parseBasename(File file) {
        return StringUtils.substringBeforeLast(
            StringUtils.substringBefore(file.getName(), "."), "_");
    }
}