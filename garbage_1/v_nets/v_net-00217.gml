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
  id 217
  arrival_time 3906.022044216468
  lifetime 1256.6827669658437
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 23
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 50
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 0
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 33
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 25
    rom 19
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 33
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
]
