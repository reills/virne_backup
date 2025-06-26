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
  id 1731
  arrival_time 38675.27264631847
  lifetime 244.67634411329885
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 40
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 3
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 17
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 25
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 20
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 0
    gpu 43
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 8
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 49
    rom 37
  ]
  node [
    id 8
    label "8"
    cpu 46
    gpu 11
    rom 47
  ]
  node [
    id 9
    label "9"
    cpu 14
    gpu 8
    rom 47
  ]
  node [
    id 10
    label "10"
    cpu 6
    gpu 16
    rom 15
  ]
  node [
    id 11
    label "11"
    cpu 30
    gpu 29
    rom 25
  ]
  node [
    id 12
    label "12"
    cpu 16
    gpu 35
    rom 27
  ]
  node [
    id 13
    label "13"
    cpu 8
    gpu 15
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
  edge [
    source 8
    target 9
    bw 40
  ]
  edge [
    source 9
    target 10
    bw 46
  ]
  edge [
    source 10
    target 11
    bw 30
  ]
  edge [
    source 11
    target 12
    bw 28
  ]
  edge [
    source 12
    target 13
    bw 16
  ]
]
