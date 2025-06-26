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
  id 174
  arrival_time 3293.1449582563123
  lifetime 129.70049766694095
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 2
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 41
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 48
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 11
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 11
    rom 48
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 32
    rom 28
  ]
  node [
    id 6
    label "6"
    cpu 46
    gpu 27
    rom 34
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 34
    rom 28
  ]
  node [
    id 8
    label "8"
    cpu 44
    gpu 36
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 38
    gpu 30
    rom 45
  ]
  node [
    id 10
    label "10"
    cpu 19
    gpu 46
    rom 21
  ]
  node [
    id 11
    label "11"
    cpu 33
    gpu 16
    rom 0
  ]
  node [
    id 12
    label "12"
    cpu 27
    gpu 17
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 46
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 50
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 48
  ]
  edge [
    source 9
    target 10
    bw 19
  ]
  edge [
    source 10
    target 11
    bw 33
  ]
  edge [
    source 11
    target 12
    bw 44
  ]
]
