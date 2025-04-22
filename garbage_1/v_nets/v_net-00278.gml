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
  id 278
  arrival_time 5357.494376252648
  lifetime 420.0016251239207
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 12
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 16
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 41
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 1
    gpu 38
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 17
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 1
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
]
