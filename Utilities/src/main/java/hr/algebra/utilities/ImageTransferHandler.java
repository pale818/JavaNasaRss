// File: src/hr/algebra/utilities/ImageTransferHandler.java

package hr.algebra.utilities;

import java.awt.Image;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.io.IOException;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JComponent;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.SwingUtilities;
import javax.swing.TransferHandler;

public class ImageTransferHandler extends TransferHandler {

    @Override
    public int getSourceActions(JComponent c) {
        return COPY;
    }

    @Override
    protected Transferable createTransferable(JComponent c) {
        JLabel source = (JLabel) c;
        Icon icon = source.getIcon();
        if (icon instanceof ImageIcon imageIcon) {
            return new ImageTransferable(imageIcon.getImage());
        }
        return null;
    }

    @Override
    public boolean canImport(TransferSupport support) {
        System.out.println("IMAGE_FLAVOR " + ImageTransferable.IMAGE_FLAVOR);
        return support.isDataFlavorSupported(ImageTransferable.IMAGE_FLAVOR);
    }

    @Override
    public boolean importData(TransferSupport support) {
        if (!canImport(support)) {
            return false;
        }
        try {
            Image originalImage = (Image) support.getTransferable().getTransferData(ImageTransferable.IMAGE_FLAVOR);
            JLabel destinationLabel = (JLabel) support.getComponent();
            destinationLabel.putClientProperty("originalImage", originalImage);
            
            JFrame frame = (JFrame) SwingUtilities.getWindowAncestor(destinationLabel);
            int frameWidth = frame.getContentPane().getWidth();
            int frameHeight = frame.getContentPane().getHeight();

            double imageAspect = (double) originalImage.getWidth(null) / originalImage.getHeight(null);
            double frameAspect = (double) frameWidth / frameHeight;

            int newWidth, newHeight;
            if (imageAspect > frameAspect) {
                newWidth = frameWidth;
                newHeight = (int) (frameWidth / imageAspect);
            } else {
                newHeight = frameHeight;
                newWidth = (int) (frameHeight * imageAspect);
            }
            
            Image scaledImage = originalImage.getScaledInstance(newWidth, newHeight, Image.SCALE_SMOOTH);
            destinationLabel.setIcon(new ImageIcon(scaledImage));
            destinationLabel.setText("");
            return true;
            
        } catch (UnsupportedFlavorException | IOException e) {
            e.printStackTrace();
        }
        return false;
    }
}