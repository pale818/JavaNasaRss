/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package hr.algebra.utilities;

import java.awt.Image;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.io.IOException;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.TransferHandler;

/**
 *
 * @author paola
 */
public class ImageTransferHandler extends TransferHandler  {
    
    
     @Override
    public int getSourceActions(JComponent c) {
        return COPY;
    }

    @Override
    protected Transferable createTransferable(JComponent c) {
        JLabel source = (JLabel) c;
        Icon icon = source.getIcon();
        if (icon instanceof ImageIcon) {
            return new ImageTransferable(((ImageIcon) icon).getImage());
        }
        return null;
    }

    @Override
    public boolean canImport(TransferSupport support) {
        // We only support importing image data
        return support.isDataFlavorSupported(DataFlavor.imageFlavor);
    }

    @Override
    public boolean importData(TransferSupport support) {
        if (!canImport(support)) {
            return false;
        }

        try {
            // Get the image from the transferable object
            Image image = (Image) support.getTransferable().getTransferData(DataFlavor.imageFlavor);
            
            // Set the icon on the destination component
            JLabel destination = (JLabel) support.getComponent();
            destination.setIcon(new ImageIcon(image));
            destination.setText(""); // Clear the "Drop here" text
            return true;
            
        } catch (UnsupportedFlavorException | IOException e) {
            e.printStackTrace();
        }
        return false;
    }
}
