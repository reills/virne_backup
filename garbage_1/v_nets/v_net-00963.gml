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
  id 963
  arrival_time 20486.407691644086
  lifetime 929.9671912045192
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 23
    rom 34
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 27
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 29
    gpu 39
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 28
    rom 31
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 2
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 22
    gpu 45
    rom 15
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 0
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 13
  ]
]
