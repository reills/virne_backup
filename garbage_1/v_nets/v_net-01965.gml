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
  id 1965
  arrival_time 42960.684899383654
  lifetime 990.1982238626351
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 38
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 44
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 31
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 46
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 7
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 28
    rom 38
  ]
  node [
    id 6
    label "6"
    cpu 25
    gpu 41
    rom 22
  ]
  node [
    id 7
    label "7"
    cpu 41
    gpu 47
    rom 44
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 23
    rom 9
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 50
    rom 48
  ]
  node [
    id 10
    label "10"
    cpu 45
    gpu 48
    rom 26
  ]
  node [
    id 11
    label "11"
    cpu 45
    gpu 16
    rom 15
  ]
  node [
    id 12
    label "12"
    cpu 33
    gpu 50
    rom 35
  ]
  node [
    id 13
    label "13"
    cpu 23
    gpu 12
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 31
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 42
  ]
  edge [
    source 8
    target 9
    bw 31
  ]
  edge [
    source 9
    target 10
    bw 9
  ]
  edge [
    source 10
    target 11
    bw 19
  ]
  edge [
    source 11
    target 12
    bw 41
  ]
  edge [
    source 12
    target 13
    bw 45
  ]
]
