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
  id 166
  arrival_time 3102.976719408197
  lifetime 982.0509518269301
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 39
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 12
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 41
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 12
    gpu 47
    rom 14
  ]
  node [
    id 4
    label "4"
    cpu 33
    gpu 24
    rom 48
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 38
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 27
    gpu 42
    rom 9
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 33
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 43
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
  edge [
    source 6
    target 7
    bw 27
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
]
