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
  id 1380
  arrival_time 29213.95187083003
  lifetime 1370.7484054887568
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 22
    gpu 36
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 36
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 33
    rom 38
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 36
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 13
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 17
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 27
    gpu 49
    rom 36
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 33
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 0
    rom 27
  ]
  node [
    id 9
    label "9"
    cpu 37
    gpu 3
    rom 34
  ]
  node [
    id 10
    label "10"
    cpu 38
    gpu 45
    rom 45
  ]
  node [
    id 11
    label "11"
    cpu 2
    gpu 1
    rom 30
  ]
  node [
    id 12
    label "12"
    cpu 36
    gpu 0
    rom 22
  ]
  node [
    id 13
    label "13"
    cpu 4
    gpu 5
    rom 0
  ]
  node [
    id 14
    label "14"
    cpu 29
    gpu 48
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 49
  ]
  edge [
    source 9
    target 10
    bw 0
  ]
  edge [
    source 10
    target 11
    bw 47
  ]
  edge [
    source 11
    target 12
    bw 5
  ]
  edge [
    source 12
    target 13
    bw 31
  ]
  edge [
    source 13
    target 14
    bw 15
  ]
]
