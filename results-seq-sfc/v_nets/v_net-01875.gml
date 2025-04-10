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
  id 1875
  arrival_time 41115.050013857275
  lifetime 2455.188253460975
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 14
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 48
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 6
    gpu 49
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 38
    gpu 24
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 27
    rom 26
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 39
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 11
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 10
    gpu 23
    rom 5
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 12
    rom 49
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 41
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 8
    gpu 46
    rom 29
  ]
  node [
    id 11
    label "11"
    cpu 19
    gpu 3
    rom 23
  ]
  node [
    id 12
    label "12"
    cpu 17
    gpu 10
    rom 50
  ]
  node [
    id 13
    label "13"
    cpu 12
    gpu 37
    rom 50
  ]
  node [
    id 14
    label "14"
    cpu 24
    gpu 20
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 37
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
  edge [
    source 7
    target 8
    bw 47
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
  edge [
    source 9
    target 10
    bw 6
  ]
  edge [
    source 10
    target 11
    bw 37
  ]
  edge [
    source 11
    target 12
    bw 7
  ]
  edge [
    source 12
    target 13
    bw 37
  ]
  edge [
    source 13
    target 14
    bw 26
  ]
]
