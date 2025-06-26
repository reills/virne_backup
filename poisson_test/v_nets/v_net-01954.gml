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
  id 1954
  arrival_time 42837.84457444026
  lifetime 198.1443335578536
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 42
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 13
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 24
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 10
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 6
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
]
