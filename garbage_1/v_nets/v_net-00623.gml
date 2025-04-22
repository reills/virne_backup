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
  id 623
  arrival_time 12844.90531700123
  lifetime 251.46209955165045
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 37
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 12
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 13
    rom 18
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 42
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 36
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 12
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 44
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 28
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 10
    gpu 13
    rom 26
  ]
  node [
    id 9
    label "9"
    cpu 21
    gpu 34
    rom 41
  ]
  node [
    id 10
    label "10"
    cpu 50
    gpu 21
    rom 43
  ]
  node [
    id 11
    label "11"
    cpu 0
    gpu 33
    rom 29
  ]
  node [
    id 12
    label "12"
    cpu 32
    gpu 40
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 34
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
  edge [
    source 7
    target 8
    bw 6
  ]
  edge [
    source 8
    target 9
    bw 42
  ]
  edge [
    source 9
    target 10
    bw 10
  ]
  edge [
    source 10
    target 11
    bw 32
  ]
  edge [
    source 11
    target 12
    bw 3
  ]
]
