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
  id 668
  arrival_time 14233.512005304636
  lifetime 2513.0240281743263
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 6
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 10
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 48
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 44
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 42
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 14
    rom 33
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 27
    rom 24
  ]
  node [
    id 7
    label "7"
    cpu 43
    gpu 42
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 38
    gpu 43
    rom 38
  ]
  node [
    id 9
    label "9"
    cpu 50
    gpu 29
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 28
    gpu 21
    rom 2
  ]
  node [
    id 11
    label "11"
    cpu 9
    gpu 45
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 12
  ]
  edge [
    source 7
    target 8
    bw 19
  ]
  edge [
    source 8
    target 9
    bw 8
  ]
  edge [
    source 9
    target 10
    bw 25
  ]
  edge [
    source 10
    target 11
    bw 43
  ]
]
