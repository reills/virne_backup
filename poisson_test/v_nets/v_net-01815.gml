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
  id 1815
  arrival_time 40209.52234796905
  lifetime 2236.902969397069
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 40
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 15
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 35
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 24
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 9
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 31
    gpu 3
    rom 33
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 8
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 28
    gpu 33
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 8
    gpu 41
    rom 9
  ]
  node [
    id 9
    label "9"
    cpu 22
    gpu 50
    rom 11
  ]
  node [
    id 10
    label "10"
    cpu 26
    gpu 0
    rom 11
  ]
  node [
    id 11
    label "11"
    cpu 41
    gpu 42
    rom 29
  ]
  node [
    id 12
    label "12"
    cpu 7
    gpu 2
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 44
  ]
  edge [
    source 7
    target 8
    bw 18
  ]
  edge [
    source 8
    target 9
    bw 2
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
  edge [
    source 10
    target 11
    bw 15
  ]
  edge [
    source 11
    target 12
    bw 38
  ]
]
