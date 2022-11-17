const fs = require('fs');
const xmldoc = require('xmldoc');

const removeAttrRecursively = (node)=> {
    if(node?.attr?.fill){
        delete node.attr.fill;
    }
    if(node?.children?.length){
        node.children.map(child => {
            return removeAttrRecursively(child);
        })
    }
    return node;
}

const dirIn = `images/icons-in`;
const dirOut = `images/icons-out`;

console.log('Start...');
const dirList = fs.readdirSync(dirIn);
if (!fs.existsSync(dirOut)){
    fs.mkdirSync(dirOut);
}
dirList.forEach((svgFilename) => {
    const fileContent = fs.readFileSync(`${dirIn}/${svgFilename}`,{encoding: 'utf-8'});
    const document = new xmldoc.XmlDocument(fileContent);
    const resultDoc = removeAttrRecursively(document);
    console.log('Writing', svgFilename);
    fs.writeFileSync(`${dirOut}/${svgFilename}`, resultDoc.toString(),{encoding: 'utf-8'});
})
console.log('Done.');