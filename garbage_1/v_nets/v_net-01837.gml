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
  id 1837
  arrival_time 40537.81296641923
  lifetime 512.1290873055938
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 32
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 49
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 39
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 42
    rom 29
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 22
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 26
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 43
    rom 27
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 14
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 44
    gpu 37
    rom 8
  ]
  node [
    id 9
    label "9"
    cpu 23
    gpu 31
    rom 42
  ]
  node [
    id 10
    label "10"
    cpu 25
    gpu 34
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
  edge [
    source 6
    target 7
    bw 35
  ]
  edge [
    source 7
    target 8
    bw 0
  ]
  edge [
    source 8
    target 9
    bw 0
  ]
  edge [
    source 9
    target 10
    bw 34
  ]
]
