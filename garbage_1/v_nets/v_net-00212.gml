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
  id 212
  arrival_time 3795.6039000182896
  lifetime 1632.9187505240577
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 40
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 18
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 5
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 23
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 36
    gpu 4
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 39
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 3
    rom 2
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 8
    rom 45
  ]
  node [
    id 8
    label "8"
    cpu 34
    gpu 5
    rom 7
  ]
  node [
    id 9
    label "9"
    cpu 32
    gpu 42
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 10
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 24
  ]
]
