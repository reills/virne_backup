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
  id 35
  arrival_time 610.3873819315597
  lifetime 740.7918529108939
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 23
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 36
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 36
    gpu 25
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 27
    rom 39
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 31
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 30
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 12
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 40
    gpu 44
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 17
    gpu 8
    rom 7
  ]
  node [
    id 9
    label "9"
    cpu 34
    gpu 36
    rom 27
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 37
    rom 12
  ]
  node [
    id 11
    label "11"
    cpu 12
    gpu 15
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 28
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
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
  edge [
    source 8
    target 9
    bw 44
  ]
  edge [
    source 9
    target 10
    bw 16
  ]
  edge [
    source 10
    target 11
    bw 13
  ]
]
