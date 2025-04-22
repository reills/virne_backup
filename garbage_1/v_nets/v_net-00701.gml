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
  id 701
  arrival_time 14773.407687274153
  lifetime 224.41389849434157
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 34
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 24
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 12
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 9
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 49
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 42
    rom 23
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 6
    rom 15
  ]
  node [
    id 7
    label "7"
    cpu 40
    gpu 31
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 33
  ]
  edge [
    source 6
    target 7
    bw 22
  ]
]
