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
  id 1331
  arrival_time 28063.474458655386
  lifetime 254.75650683983216
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 42
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 45
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 24
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 35
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 50
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 22
    rom 0
  ]
  node [
    id 6
    label "6"
    cpu 45
    gpu 47
    rom 40
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 32
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 30
    gpu 27
    rom 18
  ]
  node [
    id 9
    label "9"
    cpu 45
    gpu 44
    rom 34
  ]
  node [
    id 10
    label "10"
    cpu 24
    gpu 38
    rom 38
  ]
  node [
    id 11
    label "11"
    cpu 35
    gpu 49
    rom 33
  ]
  node [
    id 12
    label "12"
    cpu 39
    gpu 39
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 11
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
  edge [
    source 8
    target 9
    bw 25
  ]
  edge [
    source 9
    target 10
    bw 24
  ]
  edge [
    source 10
    target 11
    bw 29
  ]
  edge [
    source 11
    target 12
    bw 15
  ]
]
