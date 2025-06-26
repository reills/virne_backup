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
  id 1963
  arrival_time 42952.425485916865
  lifetime 480.09530983053355
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 37
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 37
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 30
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 29
    gpu 15
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 32
    gpu 17
    rom 25
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 15
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 38
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 3
    gpu 6
    rom 5
  ]
  node [
    id 8
    label "8"
    cpu 18
    gpu 11
    rom 15
  ]
  node [
    id 9
    label "9"
    cpu 22
    gpu 41
    rom 19
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 17
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 28
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
  edge [
    source 6
    target 7
    bw 4
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 12
  ]
  edge [
    source 9
    target 10
    bw 4
  ]
]
