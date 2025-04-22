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
  id 1030
  arrival_time 21857.677685560953
  lifetime 2408.7955371516473
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 12
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 33
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 44
    rom 38
  ]
  node [
    id 3
    label "3"
    cpu 42
    gpu 29
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 16
    gpu 4
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 5
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 10
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 7
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 36
    gpu 25
    rom 42
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 28
    rom 12
  ]
  node [
    id 10
    label "10"
    cpu 48
    gpu 18
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 30
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 21
  ]
  edge [
    source 6
    target 7
    bw 41
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
  edge [
    source 9
    target 10
    bw 25
  ]
]
