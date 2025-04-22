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
  id 846
  arrival_time 17550.39950235795
  lifetime 564.8454133858437
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 21
    gpu 23
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 44
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 0
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 39
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 26
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 41
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 50
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 3
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
]
