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
  id 458
  arrival_time 8673.17757420586
  lifetime 74.26118774129833
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 33
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 41
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 45
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 4
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 22
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 26
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 28
    gpu 39
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 46
    rom 30
  ]
  node [
    id 8
    label "8"
    cpu 42
    gpu 9
    rom 29
  ]
  node [
    id 9
    label "9"
    cpu 34
    gpu 18
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 4
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 21
  ]
  edge [
    source 6
    target 7
    bw 7
  ]
  edge [
    source 7
    target 8
    bw 18
  ]
  edge [
    source 8
    target 9
    bw 10
  ]
]
