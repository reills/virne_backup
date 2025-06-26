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
  id 290
  arrival_time 5652.631604378916
  lifetime 1338.7022343356466
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 44
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 50
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 49
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 14
    rom 16
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 42
    rom 45
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 10
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 15
    gpu 8
    rom 36
  ]
  node [
    id 7
    label "7"
    cpu 38
    gpu 26
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 47
    gpu 49
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 30
    gpu 16
    rom 5
  ]
  node [
    id 10
    label "10"
    cpu 27
    gpu 6
    rom 0
  ]
  node [
    id 11
    label "11"
    cpu 41
    gpu 27
    rom 20
  ]
  node [
    id 12
    label "12"
    cpu 0
    gpu 6
    rom 49
  ]
  node [
    id 13
    label "13"
    cpu 14
    gpu 11
    rom 47
  ]
  node [
    id 14
    label "14"
    cpu 29
    gpu 25
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 46
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 13
  ]
  edge [
    source 7
    target 8
    bw 4
  ]
  edge [
    source 8
    target 9
    bw 13
  ]
  edge [
    source 9
    target 10
    bw 44
  ]
  edge [
    source 10
    target 11
    bw 50
  ]
  edge [
    source 11
    target 12
    bw 33
  ]
  edge [
    source 12
    target 13
    bw 27
  ]
  edge [
    source 13
    target 14
    bw 48
  ]
]
