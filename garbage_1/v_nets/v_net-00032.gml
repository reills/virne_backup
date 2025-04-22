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
  id 32
  arrival_time 589.9277486479177
  lifetime 633.5224906411278
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 48
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 11
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 9
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 29
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 19
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 42
    rom 31
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 12
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 7
  ]
  edge [
    source 5
    target 6
    bw 20
  ]
]
