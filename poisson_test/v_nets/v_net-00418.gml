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
  id 418
  arrival_time 8249.83786055766
  lifetime 322.58623626299783
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 41
    rom 38
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 39
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 18
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 40
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 10
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 33
    gpu 15
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 9
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 26
    rom 39
  ]
  node [
    id 8
    label "8"
    cpu 21
    gpu 0
    rom 22
  ]
  node [
    id 9
    label "9"
    cpu 9
    gpu 16
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 7
  ]
]
