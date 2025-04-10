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
  id 765
  arrival_time 16068.381903976679
  lifetime 1628.869251963599
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 35
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 33
    rom 46
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 47
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 40
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 30
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 5
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
]
