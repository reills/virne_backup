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
  id 231
  arrival_time 4210.332223396519
  lifetime 728.4617286271177
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 37
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 39
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 49
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 33
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 9
    gpu 10
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 45
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 38
    rom 36
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 27
    rom 2
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 9
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 30
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 42
  ]
  edge [
    source 7
    target 8
    bw 20
  ]
]
