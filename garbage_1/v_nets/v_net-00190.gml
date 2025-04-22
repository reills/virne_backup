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
  id 190
  arrival_time 3425.472436330157
  lifetime 21.70093430389449
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 12
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 2
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 14
    rom 11
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 26
    rom 28
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 27
    rom 32
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 37
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 10
    gpu 10
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 35
    rom 0
  ]
  node [
    id 8
    label "8"
    cpu 19
    gpu 1
    rom 33
  ]
  node [
    id 9
    label "9"
    cpu 15
    gpu 33
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
  edge [
    source 2
    target 3
    bw 49
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 6
  ]
  edge [
    source 6
    target 7
    bw 22
  ]
  edge [
    source 7
    target 8
    bw 13
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
]
