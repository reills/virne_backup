graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 346
  arrival_time 6576.585180376628
  lifetime 203.64522310912818
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 44
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 21
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 0
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
]
