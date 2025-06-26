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
  id 1873
  arrival_time 41033.59095348326
  lifetime 2020.0986493389505
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 18
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 16
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 20
    gpu 46
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 23
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 23
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 16
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 45
    rom 1
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 28
    rom 45
  ]
  node [
    id 8
    label "8"
    cpu 4
    gpu 13
    rom 8
  ]
  node [
    id 9
    label "9"
    cpu 33
    gpu 34
    rom 1
  ]
  node [
    id 10
    label "10"
    cpu 18
    gpu 17
    rom 9
  ]
  node [
    id 11
    label "11"
    cpu 41
    gpu 33
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 46
  ]
  edge [
    source 5
    target 6
    bw 48
  ]
  edge [
    source 6
    target 7
    bw 12
  ]
  edge [
    source 7
    target 8
    bw 37
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
  edge [
    source 9
    target 10
    bw 22
  ]
  edge [
    source 10
    target 11
    bw 1
  ]
]
