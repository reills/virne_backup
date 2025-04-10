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
  id 599
  arrival_time 12395.645464748623
  lifetime 667.1128748564417
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 31
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 27
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 6
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 5
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 5
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 26
    gpu 8
    rom 27
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 2
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 29
    gpu 40
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 46
    gpu 50
    rom 40
  ]
  node [
    id 9
    label "9"
    cpu 17
    gpu 30
    rom 6
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 32
    rom 12
  ]
  node [
    id 11
    label "11"
    cpu 22
    gpu 5
    rom 11
  ]
  node [
    id 12
    label "12"
    cpu 46
    gpu 4
    rom 8
  ]
  node [
    id 13
    label "13"
    cpu 22
    gpu 42
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 33
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
  edge [
    source 8
    target 9
    bw 4
  ]
  edge [
    source 9
    target 10
    bw 26
  ]
  edge [
    source 10
    target 11
    bw 21
  ]
  edge [
    source 11
    target 12
    bw 26
  ]
  edge [
    source 12
    target 13
    bw 12
  ]
]
