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
  id 673
  arrival_time 14334.365630251279
  lifetime 839.4517501950917
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 27
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 6
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 10
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 48
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 2
    gpu 38
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 18
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 23
    gpu 50
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 12
    gpu 2
    rom 34
  ]
  node [
    id 8
    label "8"
    cpu 7
    gpu 15
    rom 9
  ]
  node [
    id 9
    label "9"
    cpu 35
    gpu 24
    rom 20
  ]
  node [
    id 10
    label "10"
    cpu 43
    gpu 44
    rom 13
  ]
  node [
    id 11
    label "11"
    cpu 2
    gpu 41
    rom 28
  ]
  node [
    id 12
    label "12"
    cpu 1
    gpu 42
    rom 38
  ]
  node [
    id 13
    label "13"
    cpu 50
    gpu 7
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 20
  ]
  edge [
    source 6
    target 7
    bw 0
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
  edge [
    source 8
    target 9
    bw 12
  ]
  edge [
    source 9
    target 10
    bw 45
  ]
  edge [
    source 10
    target 11
    bw 28
  ]
  edge [
    source 11
    target 12
    bw 1
  ]
  edge [
    source 12
    target 13
    bw 13
  ]
]
