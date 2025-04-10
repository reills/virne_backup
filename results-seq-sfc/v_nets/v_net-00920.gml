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
  id 920
  arrival_time 19660.606916256453
  lifetime 916.479279956001
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 18
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 29
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 35
    rom 22
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 41
    rom 22
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 42
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 41
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 32
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 9
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 24
  ]
  edge [
    source 6
    target 7
    bw 45
  ]
]
