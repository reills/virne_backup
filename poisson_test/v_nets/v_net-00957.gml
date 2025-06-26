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
  id 957
  arrival_time 20381.35103804658
  lifetime 2291.918678657614
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 28
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 25
    gpu 30
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 7
    rom 31
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 10
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 26
    rom 48
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 49
    rom 50
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 29
    rom 30
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 14
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 15
    gpu 49
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 0
    rom 7
  ]
  node [
    id 10
    label "10"
    cpu 37
    gpu 24
    rom 26
  ]
  node [
    id 11
    label "11"
    cpu 45
    gpu 15
    rom 23
  ]
  node [
    id 12
    label "12"
    cpu 6
    gpu 20
    rom 25
  ]
  node [
    id 13
    label "13"
    cpu 39
    gpu 38
    rom 15
  ]
  node [
    id 14
    label "14"
    cpu 22
    gpu 35
    rom 32
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 21
  ]
  edge [
    source 8
    target 9
    bw 37
  ]
  edge [
    source 9
    target 10
    bw 32
  ]
  edge [
    source 10
    target 11
    bw 17
  ]
  edge [
    source 11
    target 12
    bw 4
  ]
  edge [
    source 12
    target 13
    bw 47
  ]
  edge [
    source 13
    target 14
    bw 47
  ]
]
