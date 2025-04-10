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
  id 530
  arrival_time 10107.919493811374
  lifetime 31.035759920103843
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 18
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 40
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 45
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 47
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 30
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 0
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 48
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 1
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
]
