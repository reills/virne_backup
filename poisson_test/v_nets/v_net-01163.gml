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
  id 1163
  arrival_time 24128.305551090343
  lifetime 1245.7732927459888
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 39
    gpu 30
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 18
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 9
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 39
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 45
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 11
    rom 10
  ]
  node [
    id 6
    label "6"
    cpu 4
    gpu 24
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 38
    rom 40
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 42
    rom 48
  ]
  node [
    id 9
    label "9"
    cpu 12
    gpu 43
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 34
    gpu 9
    rom 46
  ]
  node [
    id 11
    label "11"
    cpu 28
    gpu 44
    rom 45
  ]
  node [
    id 12
    label "12"
    cpu 28
    gpu 36
    rom 36
  ]
  node [
    id 13
    label "13"
    cpu 1
    gpu 28
    rom 2
  ]
  node [
    id 14
    label "14"
    cpu 45
    gpu 29
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 30
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
  edge [
    source 8
    target 9
    bw 1
  ]
  edge [
    source 9
    target 10
    bw 5
  ]
  edge [
    source 10
    target 11
    bw 36
  ]
  edge [
    source 11
    target 12
    bw 32
  ]
  edge [
    source 12
    target 13
    bw 47
  ]
  edge [
    source 13
    target 14
    bw 0
  ]
]
