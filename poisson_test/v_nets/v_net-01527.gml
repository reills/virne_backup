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
  id 1527
  arrival_time 33819.781582692325
  lifetime 1702.2385705678307
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 0
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 22
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 33
    rom 43
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 3
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 49
    gpu 42
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 2
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 43
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 46
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 41
    gpu 5
    rom 44
  ]
  node [
    id 9
    label "9"
    cpu 29
    gpu 43
    rom 9
  ]
  node [
    id 10
    label "10"
    cpu 20
    gpu 24
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 32
  ]
  edge [
    source 7
    target 8
    bw 6
  ]
  edge [
    source 8
    target 9
    bw 10
  ]
  edge [
    source 9
    target 10
    bw 15
  ]
]
