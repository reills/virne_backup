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
  id 95
  arrival_time 1932.6923686236191
  lifetime 559.0579526398963
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 6
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 35
    rom 35
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 12
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 42
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 44
    gpu 1
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 3
    rom 45
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 45
    rom 19
  ]
  node [
    id 7
    label "7"
    cpu 0
    gpu 16
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 5
    gpu 25
    rom 2
  ]
  node [
    id 9
    label "9"
    cpu 49
    gpu 49
    rom 23
  ]
  node [
    id 10
    label "10"
    cpu 37
    gpu 12
    rom 8
  ]
  node [
    id 11
    label "11"
    cpu 19
    gpu 28
    rom 3
  ]
  node [
    id 12
    label "12"
    cpu 12
    gpu 40
    rom 5
  ]
  node [
    id 13
    label "13"
    cpu 17
    gpu 9
    rom 38
  ]
  node [
    id 14
    label "14"
    cpu 23
    gpu 21
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 36
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 31
  ]
  edge [
    source 8
    target 9
    bw 45
  ]
  edge [
    source 9
    target 10
    bw 20
  ]
  edge [
    source 10
    target 11
    bw 0
  ]
  edge [
    source 11
    target 12
    bw 46
  ]
  edge [
    source 12
    target 13
    bw 41
  ]
  edge [
    source 13
    target 14
    bw 13
  ]
]
