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
  id 1107
  arrival_time 23044.488194207705
  lifetime 87.6716698358838
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 21
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 50
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 41
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 1
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 34
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 14
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 31
    rom 42
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 14
    rom 32
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 36
    rom 28
  ]
  node [
    id 9
    label "9"
    cpu 8
    gpu 26
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 30
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 22
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
  edge [
    source 7
    target 8
    bw 3
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
]
