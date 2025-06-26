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
  id 1859
  arrival_time 40922.2216300151
  lifetime 1258.012946646139
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 8
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 8
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 4
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 42
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 10
    rom 47
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 21
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 1
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 23
    gpu 29
    rom 22
  ]
  node [
    id 8
    label "8"
    cpu 45
    gpu 26
    rom 11
  ]
  node [
    id 9
    label "9"
    cpu 38
    gpu 9
    rom 46
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 16
  ]
  edge [
    source 7
    target 8
    bw 15
  ]
  edge [
    source 8
    target 9
    bw 39
  ]
]
